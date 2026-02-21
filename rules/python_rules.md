---
applyTo: "**/*.py"
---

# Python Coding Rules

1. Please use python3.12+ type annotations.
2. Follow PEP 8 style guidelines.
3. Please use new style string formatting (f-strings).
4. Use list comprehensions where appropriate.
5. Avoid using wildcard imports (e.g., from module import \*).
6. Write docstrings for all public modules, functions, classes, and methods.
7. Use logging instead of print statements for debugging and information messages.
8. Handle exceptions gracefully using try-except blocks.
9. Write unit tests for all functions and classes.
10. Use virtual environments to manage project dependencies.
11. Keep functions and methods short and focused on a single task.
12. Use type hints for function parameters and return types.
13. Avoid using global variables; prefer passing parameters and returning values.
14. Use meaningful variable and function names that convey purpose.
15. Regularly refactor code to improve readability and maintainability.
16. Use new python type hints e.g. `list[int]` instead of `List[int]` from
    `typing` module.
17. Please use pydantic v2 for data validation and settings management.
18. When working with asynchronous code, prefer using `async` and `await` keywords.
19. Use context managers (with statements) for resource management (e.g., file handling).
20. Follow SOLID principles for object-oriented design.
21. Use dependency injection to manage dependencies in your classes and functions.
22. Avoid deep nesting of code; consider breaking down complex functions into
    smaller ones.
23. Use pyrights for type checking and static analysis, and ruff for linting.
24. Document code changes and decisions in version control commit messages.
25. Regularly update dependencies to their latest stable versions to ensure
    security and performance.
26. Use linters and formatters (e.g., flake8, black) to maintain code quality
    and consistency.
27. When working with data, prefer using pandas for data manipulation and analysis.
28. Use environment variables for configuration settings instead of hardcoding
    them in the code.
29. When writing APIs, follow RESTful principles and use frameworks like FastAPI.
30. Always consider performance implications when writing code, and optimize
    where necessary without sacrificing readability.
31. Avoid using deprecated libraries and functions; stay updated with the latest
    Python ecosystem trends.
