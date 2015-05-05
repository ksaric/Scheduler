:- use_module(library(csv)).
:- use_module(library(apply)).
:- use_module(library(clpfd)).

:- dynamic task/5.

/**
 * Main call
 *
 * It calls main function. The main call - read CSV and then try to schedule.
 */

main(TASK_ROWS) :- 
	read_default_csv_no_header(ROWS),
	maplist(cumulative_tasks_constraints, ROWS, TASK_ROWS),
	cumulative(TASK_ROWS).

/**
 * Constraints for a task. 
 * It assumes that tasks are possible from 8-20 till 8-20 and their length can be 1-10.
 */

% cumulative_tasks_constraints(pre_task(13,1,18,1,_), TASK).
cumulative_tasks_constraints(pre_task(FROM,LENGTH,TO,RESOURCES,NAME_SURNAME), 
							 task(FROM_COMBINATION,LENGTH,TO_COMBINATION,RESOURCES,NAME_SURNAME)) :-
	FROM in 8..20
	#/\ LENGTH in 1..10
	#/\ TO in 8..20
	#/\ FROM_COMBINATION in FROM..TO 
	#/\ TO_COMBINATION in FROM..TO 
	#/\ FROM_COMBINATION #< TO_COMBINATION 
	#/\ (TO_COMBINATION - FROM_COMBINATION) #>= LENGTH,
	%labeling(max(LENGTH)),
	indomain(FROM_COMBINATION),
	indomain(LENGTH),
	indomain(TO_COMBINATION).

% The default FILENAME
read_default_csv(LIST) :- 
	get_rows_data('data.csv', LIST).

% Get CSV data, remove the header
read_default_csv_no_header(ROWS) :- 
	get_rows_data('data.csv', LIST),
	remove_head(LIST, ROWS).

% Read the data and ENSURE that it exists
read_data(FILENAME, ROWS) :- 
	csv_read_file(FILENAME, ROWS), 
    maplist(assert, ROWS).

% http://stackoverflow.com/questions/23183662/prolog-parsing-a-csv-file
get_rows_data(FILE, Lists):-
	csv_read_file(FILE, ROWS, [separator(0';), functor(row), arity(5)]),
	rows_to_lists(ROWS, Lists).

rows_to_lists(ROWS, RLISTS):-
	maplist(row_to_list, ROWS, LISTS),
	list_to_row(LISTS, RLISTS).

row_to_list(Row, List):-
	Row =.. [row|List].

remove_head([_|TAIL], TAIL).

% NAME_SURNAME;FROM;TO;LENGTH;RESOURCES 
list_to_row([], []).
list_to_row([H1|T1], [H2|T2]) :- 
    row_to_struct(H1, H2),
    list_to_row(T1, T2).

% convert to STRUCT
row_to_struct([NAME_SURNAME,FROM,TO,LENGTH,RESOURCES], pre_task(FROM,LENGTH,TO,RESOURCES,NAME_SURNAME)).


