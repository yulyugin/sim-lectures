ifneq ($(VERBOSE),yes)
MAKEFLAGS += -s
endif  # VERBOSE

LOG_DIR:=log
PDF_DIR:=pdf
SRC_DIR:=lectures
LECTURES=$(patsubst $(SRC_DIR)/%.tex,%,$(wildcard $(SRC_DIR)/*.tex))

OPTIONS= -xelatex -aux-directory=$(LOG_DIR) -output-directory=$(PDF_DIR)

all: $(LECTURES)

$(LECTURES):
	cd $(SRC_DIR) && latexmk $(OPTIONS) $@
	# Remove ".fls" files for some reason places to output dir by latexmk
	rm -f $(SRC_DIR)/$(PDF_DIR)/$@.fls

clean:
	cd $(SRC_DIR) && rm -rf $(LOG_DIR) $(PDF_DIR)

.DELETE_ON_ERROR:

.PHONY: all clean $(LECTURES)
