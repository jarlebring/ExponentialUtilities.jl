#


# Fallback
function alloc_mem(A,method)
    return nothing;
end


## The diagonalization based
"""
    ExpMethodDiagonalization(enforce_real=true)

Matrix exponential method corresponding to the diagonalization with `eigen` possibly by removing imaginary part introduced by the numerical approximation.

"""
struct ExpMethodDiagonalization
    enforce_real::Bool
end
ExpMethodDiagonalization()=ExpMethodDiagonalization(true);
function _exp!(A,method::ExpMethodDiagonalization,cache=nothing)
    F=eigen!(A)
    E=F.vectors*Diagonal(exp.(F.values))/F.vectors
    if (method.enforce_real && isreal(A))
        E=real.(E);
    end
    copyto!(A,E)
    return A
end



"""
    ExpMethodNative()

Matrix exponential method corresponding to calling `Base.exp`.

"""
struct ExpMethodNative
end
function _exp!(A,method::ExpMethodNative,cache=nothing)
    return exp(A)
end
