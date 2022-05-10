#!/bin/sh -e

# Define and install the packages that should be installed declaratively.
codium --install-extension jamesmaj.easy-icons || true                       # Simplistic Icons
codium --install-extension tuttieee.emacs-mcx || true                        # Emacs Emulation for VSCode
codium --install-extension abusaidm.html-snippets || true                    # Snippets for HTML
codium --install-extension xabikos.JavaScriptSnippets || true                # Snippets for JS
codium --install-extension mattn.lisp || true                                # Lisp Syntax Support / Highlighting
codium --install-extension DavidAnson.vscode-markdownlint || true            # Improvements for Markdown
codium --install-extension MrAirport.mountain || true                        # Mountain Theme
codium --install-extension arcticicestudio.nord-visual-studio-code || true   # Nord Theme
codium --install-extension christian-kohler.path-intellisense || true        # File Autocomplete
codium --install-extension esbenp.prettier-vscode || true                    # Better Syntax Highlighting
codium --install-extension ms-python.vscode-pylance || true                  # Language Server for Python
codium --install-extension ms-python.python || true                          # Python Support
codium --install-extension wayou.vscode-todo-highlight || true               # Highlight TODO Marks
#codium --install-extension vscodevim.vim                                    # Vim Emulation for VSCode
codium --install-extension redhat.vscode-yaml || true                        # YAML Support
