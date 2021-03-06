%
% This script tests diffsnorm on sparse matrices.
%

pass = [];

for m = [100 200]
  for n = [100 200]
    for isreal = [true false]

      if(isreal)
        A = 2*spdiags((1:min(m,n))',0,m,n);
      end
      if(~isreal)
        A = 2*spdiags((1:min(m,n))',0,m,n)*(1+1i);
      end

      A = A - spdiags((0:(min(m,n)-1))',1,m,n);
      A = A - spdiags((1:min(m,n))',-1,m,n);

      [U,S,V] = svd(full(A),'econ');
      A = A/S(1,1);

      [U,S,V] = svd(full(A),'econ');
      snorm = diffsnorm(A,U,S,V);
      pass = [pass snorm<.1d-10*S(1,1)];

    end
  end
end


if(all(pass))
  disp('All tests succeeded.');
end

if(~all(pass))
  error('A test failed.');
end
