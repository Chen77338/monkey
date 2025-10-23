[Mesh] 
    type = FileMesh
    file = 1.e
[]

[Variables]
    [temperature]
        order = FIRST
        family = LAGRANGE
    []
[]

[Functions]
    [axial_heat]
        type = ParsedFunction
        expression = 3.3*10e6*cos(z/0.25*pi)
    []
[]
        
[Kernels]
    [heat_conduction]
    type = HeatConduction
    variable = temperature
#    block = '1'
    []
    [heat_source]
        type = BodyForce
        variable = temperature
        function = axial_heat
    []
[]

[BCs]
    [surface]
        type = DirichletBC
        variable = temperature
        boundary = 1
        value = 1073.15
    []
[]

[Materials]
    [thermal_conductivity]
        type = GenericConstantMaterial
        block = '1'
        prop_names = 'thermal_conductivity'
        prop_values = '23.07'
    []
[]

[Problem]
    type = FEProblem
[]

[Executioner]
    type = Steady       # Steady state problem
    solve_type = NEWTON # Perform a Newton solve, uses AD to compute Jacobian terms
    petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
    petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
    exodus = true 
[]








   

