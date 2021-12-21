function M=minmod(A,B)
M=(sign(A)+sign(B))./2.*min(abs(A),abs(B));