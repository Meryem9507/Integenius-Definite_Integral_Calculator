from flask import Flask, request, jsonify
from flask_cors import CORS
from sympy import (
    symbols, sin, cos, tan, cot, sec, csc, atan, asin, acos,
    log, exp, pi, E, sqrt, Abs, integrate, oo, simplify, latex,
    solve, Rational, nan, zoo, limit, Symbol
)
from sympy.parsing.sympy_parser import parse_expr, standard_transformations, implicit_multiplication_application
import traceback

app = Flask(__name__)
CORS(app)

x = symbols('x', real=True)

transformations = standard_transformations + (implicit_multiplication_application,)
local_dict = {
    "x": x, "sin": sin, "cos": cos, "tan": tan, "cot": cot,
    "sec": sec, "csc": csc, "atan": atan, "asin": asin, "acos": acos,
    "log": log, "ln": log, "exp": exp, "pi": pi, "e": E, "E": E,
    "sqrt": sqrt, "abs": Abs, "oo": oo
}

def parse_limit(limit_str: str):
    if not limit_str:
        return None
    
    s = limit_str.strip().lower()
    if s in ['oo', '∞', 'infinity', '+oo', '+∞']:
        return oo
    elif s in ['-oo', '-∞', '-infinity']:
        return -oo
    elif s == 'e':
        return E
    elif s == 'pi':
        return pi
    else:
        try:
            return parse_expr(limit_str, transformations=transformations, local_dict=local_dict)
        except:
            try:
                return float(limit_str)
            except ValueError:
                return None

def safe_integrate(expr, var, lower=None, upper=None):
    try:
        if lower is not None and upper is not None:
            result = integrate(expr, (var, lower, upper))
        else:
            result = integrate(expr, var)
        return simplify(result)
    except Exception as e:
        print(f"Integration error: {e}")
        return None

def latex_ln(expr):
    r"""Convert log to ln in LaTeX output"""
    latex_str = latex(expr)
    return latex_str.replace(r'\log', r'\ln')

@app.route("/calculate", methods=["POST"])
def calculate_integral():
    try:
        data = request.get_json(force=True)
        function_str = data.get("function", "").strip()
        lower_limit_str = data.get("lower_limit", "").strip()
        upper_limit_str = data.get("upper_limit", "").strip()

        function_str = function_str.replace("ln(", "log(")

        if not function_str:
            return jsonify(success=False, error="Function cannot be empty.", steps=[]), 400

        try:
            expr = parse_expr(function_str, transformations=transformations, local_dict=local_dict)
        except Exception as e:
            return jsonify(success=False, error=f"Could not parse function: {str(e)}", steps=[]), 400

        lower_limit = parse_limit(lower_limit_str) if lower_limit_str else None
        upper_limit = parse_limit(upper_limit_str) if upper_limit_str else None

        steps = []
        steps.append(f"Integrand: {latex_ln(expr)}")

        simplified_expr = simplify(expr)
        steps.append(f"Simplified integrand: {latex_ln(simplified_expr)}")

        # Indefinite integral
        indefinite_integral = safe_integrate(simplified_expr, x)
        if indefinite_integral is None:
            steps.append("Could not compute the indefinite integral analytically.")
            return jsonify(
                success=False, 
                error="No analytic solution found.", 
                steps=steps
            ), 400
        
        steps.append(f"Indefinite integral: {latex_ln(indefinite_integral)} + C")

        if lower_limit is not None and upper_limit is not None:
            steps.append(f"Computing definite integral: \\int_{{{latex_ln(lower_limit)}}}^{{{latex_ln(upper_limit)}}} {latex_ln(simplified_expr)} \\, dx")
            definite_integral = safe_integrate(simplified_expr, x, lower_limit, upper_limit)

            if definite_integral is None:
                steps.append("Could not compute definite integral.")
                return jsonify(
                    success=False,
                    error="Definite integral computation failed.",
                    steps=steps
                ), 400

            simplified_result = simplify(definite_integral)
            steps.append(f"Simplified definite integral result: {latex_ln(simplified_result)}")

            # Dönüşü sembolik olarak yapıyoruz, sayısal değere öncelik vermiyoruz
            return jsonify(
                success=True,
                result=latex_ln(simplified_result),
                steps=steps,
                is_definite=True
            )

        return jsonify(
            success=True,
            result=latex_ln(indefinite_integral) + " + C",
            steps=steps,
            is_definite=False
        )

    except Exception as e:
        traceback_str = traceback.format_exc()
        print(f"Unhandled exception: {e}\n{traceback_str}")
        return jsonify(
            success=False,
            error=f"Server error: {str(e)}",
            steps=[f"Error: {str(e)}"]
        ), 500

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
