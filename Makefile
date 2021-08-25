ifeq ($(OS), Windows_NT)
UNAME := Windows_NT
else
UNAME := $(shell uname)
endif

.DELETE_ON_ERROR:

ifneq ($(VERBOSE),yes)
MAKEFLAGS += -s
endif  # VERBOSE

LOG_DIR:=log
PDF_DIR:=pdf

OPTIONS= -halt-on-error -aux-directory=$(LOG_DIR) -output-directory=$(PDF_DIR)
ifeq ($(UNAME), Linux)
LATEXCOMMAND=xelatex
RM = rm
else
LATEXCOMMAND=xelatex.exe
RM = rm.exe
endif

SRC_DIR=lectures

# find all lectures
LECTURES=$(patsubst $(SRC_DIR)/%.tex,%,$(wildcard $(SRC_DIR)/*.tex))

.PHONY: all clean $(LECTURES)

all: $(LECTURES)

$(LECTURES):
	cd $(SRC_DIR) && bash -c "while ( $(LATEXCOMMAND) $(OPTIONS) $@ ; grep -q 'Rerun to get' $(LOG_DIR)/$@.log ) do true ; done"

clean:
	cd $(SRC_DIR) && rm -rf $(LOG_DIR) $(PDF_DIR)
