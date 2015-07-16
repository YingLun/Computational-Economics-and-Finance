function [fval,fjac]=pfchoice(x, RF, er, prob, c, alg)

fjac = [];
alpha=x(1);
if alg<3,
    fval = -sign(c)*prob'*((RF+alpha*er).^(c-1).*er);
    if alg==2,
        fjac=-sign(c)*prob'*((c-1)*(RF+alpha*er).^(c-2).*er.^2);
    end;
end;
if alg==3,
    fval=-sign(c)*1/c*prob'*((RF+alpha*er).^c);
    % note: we minimize!
    fval=-fval;
end;
