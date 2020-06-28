function C = cubic(F, x)
    C = F[2] + 0.5 * x*(F[3] - F[1] + x*(2.0*F[1] - 5.0*F[2] + 4.0*F[3] - F[4] + x*(3.0*(F[2] - F[3]) + F[4] - F[1])))
endfunction
