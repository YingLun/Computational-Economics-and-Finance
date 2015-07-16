%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculates life time    %
% utility in saving model %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

function v = utilsum(s)

global betta T r w;

c = cons(s);

v = CRRA(c(T));

for t=(T-1):-1:1
    v = CRRA(c(t)) + betta*v;
end

v=-v;