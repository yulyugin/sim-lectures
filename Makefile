UNAME := $(shell uname)

.DELETE_ON_ERROR:

ifneq ($(VERBOSE),yes)
MAKEFLAGS += -s
endif  # VERBOSE

OPTIONS= -halt-on-error
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
	cd $(SRC_DIR) && bash -c "while ( $(LATEXCOMMAND) $(OPTIONS) $@ ; grep -q 'Rerun to get' $@.log ) do true ; done"

clean:
	cd $(SRC_DIR) && rm -f *.log *.aux *.nav *.out *.pdf *.snm *.toc *.vrb