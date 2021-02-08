%результати предикати записуєм сюди
:-dynamic yes_an/1 , no_an/1.
%обробка відповідей
positive(X) :- yes_an(X), !.
positive(X) :- not(no_an(X)), ask(X).


%видалити стару базу
delete:-retractall(yes_an(_)), fail.
delete:-retractall(no_an(_)), fail.
delete.
%додати позитивну або негативну відповідь
remember(X, [y]):-
    assertz(yes_an(X)).
remember(X, [n]):-
    assertz(no_an(X)),fail.
%запитуєм про ознаку і записуєм результат
ask(X):-nl, write('Властивість: '),
        write(X),
        write(' (y/n)?  - '),
        readln(Rep),
        remember(X,Rep).
%видаляєм базу і починаєм консультацію
consult :- delete, is_it(X), !,nl, write('Наш обєкт - це... '), write(X).
consult:- nl,write('Це-йой').
                                    
%об’єкти                   
is_it('імбир') :- positive('їстівний'),positive('є рослиною').
is_it('ібіс'):-positive('є твариною'),positive('літає'), positive('птах').
is_it('ізозома'):-positive('є твариною'),positive('літає'),not(positive('птах')).
is_it('їжак') :- positive('є твариною'),not(positive('літає')),positive('має колючки').
is_it('ігуана'):- positive('має колючки'),positive('є твариною') ,positive('є зеленого коляру').
is_it('івилга'):-positive('є рослиною'),positive('є зеленого коляру'),not(positive('їстівний')).
is_it('йорж'):-positive('є твариною'),positive('має колючки'),positive('їстівний').
is_it('йогурт'):-not(positive('є твариною')) ,not(positive('є рослиною')),positive('їстівний').

:-consult.
