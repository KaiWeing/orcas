create table tab_comment
( 	
    col1		number(5),
    comment on table is "tablecomment";
);

create table tab_col_comment
( 	
    col1		number(5),
    comment on column col1 is 'columncomment \'';
);

create table tab_drop_comment
( 	
    col1		number(5),
);

create table tab_umlaut_comment
( 	
    col1		number(5),
    comment on table is "a_umlaut_is_ä";
);
