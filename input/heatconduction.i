[Mesh] 
    type = FileMesh
    file = 1.e
[]

[Variables]
    [temperature]
        order = FIRST
        family = LAGRANGE
        initial_condition = 1000
    []
[]

[Functions]
    [axial_heat]
        type = ParsedFunction
        expression = 2.3*10e6*cos(z/0.25*pi)
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
    [time]
        type = HeatConductionTimeDerivative
        variable = temperature
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
    [thermal_parameter]
        type = HeatConductionMaterial
        block = '1'
        specific_heat = 148
        thermal_conductivity = 23.07
    []
    [density_material]
        type = ParsedMaterial
        property_name = density
        expression = 1.626e4
    []
[]

[Problem]
    type = FEProblem
[]

[Executioner]           
    type = Transient   
    start_time = 0  
    end_time = 5
    dt = 0.25
    solve_type = NEWTON # Perform a Newton solve, uses AD to compute Jacobian terms
    petsc_options_iname = '-pc_type -pc_hypre_type' # PETSc option pairs with values below
    petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
    exodus = true 
[]








   

