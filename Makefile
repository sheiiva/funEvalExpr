############################################
#                MATHEMATICS               #
############################################
#                                          #
#           COUTRET-ROZET Corentin         #
#                                          #
#            Project : funEvalExpr         #
#                                          #
############################################


NAME 	=	funEvalExpr

RM 		=	@rm -f
PRINT	=	@echo -e

SOURCES		=	src/
TESTS		=	test/


TESTS_SRC	=

SRC	=	

$(NAME):
	stack build --copy-bins --local-bin-path .
	@mv $@-exe $@
	$(PRINT) "\n------->\tBINARY CREATED\n"

all: $(NAME)

clean:
	$(PRINT) "\n------->\tREMOVE CACHE\n"
	$(RM) -r .stackwork

fclean: clean
	$(PRINT) "\n------->\tREMOVE BINARY\n"
	$(RM) $(NAME)
	$(RM) $(NAME)-exe

tests_run: fclean
	$(PRINT) "\nLET'S TEST:\n"
	@python3 -m pytest -v $(TESTS_SRC) --cov=$(SOURCES) --cov-report=html

re: fclean all

.PHONY: all clean fclean tests_run re