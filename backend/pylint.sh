find . -name '*.py' -not -path './venv/*' -print0 | xargs -0 pylint --msg-template="{{path}}:{{line}}: {{msg_id}}: {{msg}}" --output-format=json > pylint_output.json && pylint-json2html -f json -o pylint_report.html pylint_output.json

pylint-json2html -o pylint_after.html pylint_output.json
