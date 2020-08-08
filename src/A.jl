
# The 1-point one-loop integrals
const aa0 = 1; const aa00 = 4

@doc raw"""
    A0i(id, m^2)

one-point tensor coefficient for `id`
```math
\frac{μ^{4-D}}{iπ^{D/2} r_Γ} \int d^D q \frac{\{1, g_{μν} \} }{q^2-m^2}
\quad{\rm with}\\quad r_Γ = \frac{Γ^2(1-ε)Γ(1+ε)}{Γ(1-2ε)},~D=4-2ε.
```

Special cases:

| `id` | Int | Description |
|:---|:---:|:---|
| `aa0` |`1` | scalar one-point one-loop function, i.e., `A0(m^2)` |
| `aa00` | `4` | coefficient of ``g_{μν}`` |

"""
A0i(id, msq::Real) = ccall((:lta0i_, libLT), Float64,
        (Ref{Int64}, Ref{Float64}),
        id, msq)


A0i(id, msq::Complex) = ccall((:a0ic_, libLT), ComplexF64,
                (Ref{Int64}, Ref{ComplexF64}),
                id, msq)

"""
    A0(m^2)

the scalar one-point one-loop function
``\\dfrac{μ^{4-D}}{iπ^{D/2} r_Γ} \\int d^D q \\dfrac{1}{q^2-m^2}``
with ``r_Γ = \\dfrac{Γ^2(1-ε)Γ(1+ε)}{Γ(1-2ε)}``, ``D=4-2ε``.
"""
A0(msq::Real) = A0i(aa0, msq)

A0(msq::ComplexF64) = ccall((:lta0c_, libLT), ComplexF64,
        (Ref{ComplexF64},),
        msq)

"""
    Aget(m^2)

all one-point tensor coefficients, only defined from real `m^2`
"""
Aget(msq) = Dict(:aa0=>A0i(aa0, msq), :aa00=>A0i(aa00, msq) )
#
# Aget(msq) = ccall((:aget_, libLT), Ref{Vector{Float64}},
#         (Ref{Float64}, ),
#         msq)