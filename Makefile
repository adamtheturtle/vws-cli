SHELL := /bin/bash -euxo pipefail

include lint.mk

# Treat Sphinx warnings as errors
SPHINXOPTS := -W

.PHONY: lint
lint: \
    black \
    check-manifest \
    doc8 \
    flake8 \
    isort \
    linkcheck \
    mypy \
    pip-extra-reqs \
    pip-missing-reqs \
    pyroma \
    shellcheck \
    spelling \
    vulture \
    pylint \
    pydocstyle \

.PHONY: fix-lint
fix-lint: \
    autoflake \
    fix-black \
    fix-isort

.PHONY: docs
docs:
	make -C docs clean html SPHINXOPTS=$(SPHINXOPTS)

.PHONY: open-docs
open-docs:
	python -c 'import os, webbrowser; webbrowser.open("file://" + os.path.abspath("docs/build/html/index.html"))'
