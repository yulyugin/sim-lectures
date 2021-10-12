ifeq ($(OS), Windows_NT)
UNAME := Windows_NT
else
UNAME := $(shell uname)
endif

.DELETE_ON_ERROR:

ifneq ($(VERBOSE),yes)
MAKEFLAGS += -s
endif  # VERBOSE

LOG_DIR:=.
PDF_DIR:=pdf

OPTIONS= -halt-on-error
ifeq ($(UNAME), Linux)
LATEXCOMMAND=xelatex
RM = rm
else
LATEXCOMMAND=xelatex
RM = rm
endif

SRC_DIR=lectures

# find all lectures
LECTURES=$(patsubst $(SRC_DIR)/%.tex,%,$(wildcard $(SRC_DIR)/*.tex))

.PHONY: all clean $(LECTURES)

all: $(LECTURES)

$(LECTURES):
	cd $(SRC_DIR) && bash -c "while ( $(LATEXCOMMAND) $(OPTIONS) $@ ; grep -q 'Rerun to get' $(LOG_DIR)/$@.log ) do true ; done"

clean:
	cd $(SRC_DIR) && rm -rf *.log *.aux *.nav *.out *.snm *.toc *.vrb
