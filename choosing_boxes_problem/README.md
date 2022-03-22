# Choosing Boxes

### Problem

The problem "Choosing Boxes" is described in the
[D-Wave problem formulation guide](https://www.dwavesys.com/media/bu0lh5ee/problem-formulation-guide-2022-01-10.pdf)
in chapt. 4.4.  

<details>
<summary>
Choosing Boxes Problem
</summary>

#### Example: Choosing Boxes

We're given three boxes with different weights.
We want to choose the two boxes with the smallest sum.

| | Box 1 | Box 2 | Box 3 |
| --- | --- | --- | --- |
| Weight | 15 | 20 | 25 |

This is a simple problem – we know that the answer is to choose boxes 15 and 20.
But how do we phrase this problem as a BQM?

##### Step 1: Write Objective and Constraints

**Objective**: We are looking for the smallest sum, so our objective is "minimize the sum of
the boxes chosen".  
**Constraint**: We are allowed to choose two boxes, so our constraint is "choose exactly two
boxes".

##### Step 2: Convert Objective and Constraints into Binary Math Expressions

**Binary Variables.** First, we need to define our binary variables.
The answer that we are looking for is which boxes we should choose.
For each box, we can ask "do we choose this box?".
This points us to how we should define our binary variables.

| | Use Box i | Don't use Box i |
| --- | --- | --- |
| QUBO | $x_i = 1$ | $x_i = 0$ |
| Ising | $s_i = +1$ | $s_i = −1$ |

Once we have defined our binary variables, we can convert our objective and constraint into math expressions.

**Objective.** We consider our objective for both QUBO and Ising forms.

**QUBO:**
To figure out the sum of the boxes that are chosen, we can use a weighted sum: $15x_1 + 20x_2 + 25x_3$.
In this sum, the boxes that are chosen will have $x_i = 1$ and the boxes that are not chosen will have $x_i = 0$.
In other words, the value of boxes that are not chosen will be multiplied by zero and so we will only be adding up the value of the boxes that are chosen.
Our objective function becomes:

$$
min(15x_1 + 20x_2 + 25x_3)
$$

**Ising:**
Using our binary variables, we can convert our +1/-1 to 1/0 using the Ising to QUBO translation shown earlier, which maps +1 7→ 1 and −1 7→ 0.
Our objective function can then be written as:

$$
min \left (
  15 \left ( \frac{s_1 + 1}{2} \right ) +
  20 \left ( \frac{s_2 + 1}{2} \right ) +
  25 \left ( \frac{s_3 + 1}{2} \right )
\right )
$$

**Constraint.** We consider our constraint for both QUBO and Ising forms.

**QUBO:**
Our constraint "choose exactly two boxes" means that we need exactly two of our binary variables to have value 1, and the remaining binary variable will have value 0.
In other words, our constraint can be written as:

$$x_1 + x_2 + x_3 = 2$$

**Ising:**
Our constraint "choose exactly two boxes" means that we need exactly two of our binary variables to have value +1, and the remaining binary variable will have value -1.
In other words, our constraint can be written as:

$$s_1 + s_2 + s_3 = 1$$

##### Step 3: Transform Math Expressions into a BQM

Our objective function is fine as written, so we only need to modify our constraint.

**QUBO:**
To modify our constraint, we need to use the method for equalities.
Original constraint:
$$x_1 + x_2 + x_3 = 2$$
Move everything to one side:
$$x_1 + x_2 + x_3 − 2 = 0$$
Square the expression:
$$(x_1 + x_2 + x_3 − 2)^2$$

**Ising:**
Following the same method, we can rewrite our constraint as follows.
$$(s_1 + s_2 + s_3 − 1)^2$$

##### Step 4: Combine Expressions

Now that we have written our objective and constraint in BQM form, we can combine them together to make our final model using addition and adding in a Lagrange parameter.
Both of these can be expanded and simplified to prepare for input to an Ocean python program.

**QUBO:**
$$
min \left (
  (15 x_1 + 20 x_2 + 25 x_3) +
  γ (x_1 + x_2 + x_3 − 2)^2
\right )
$$

**Ising:**

$$
min \left (
  15 \left ( \frac{s_1 + 1}{2} \right ) +
  20 \left ( \frac{s_2 + 1}{2} \right ) +
  25 \left ( \frac{s_3 + 1}{2} \right ) +
  γ (s_1 + s_2 + s_3 − 1)^2
\right )
$$

</details>

Also see:
[https://github.com/dwave-training/choosing-boxes](https://github.com/dwave-training/choosing-boxes)

### Code

The code for the problem is in 
`choosing_boxes.ipynb` <!-- [choosing_boxes.ipynb](choosing_boxes_problem/choosing_boxes.ipynb) -->
which can be viewed at
[nbviewer.org](https://nbviewer.org/github/klezm/QuantumAnnealingPlayground/blob/main/choosing_boxes_problem/choosing_boxes.ipynb)
or opened in the
[D-Wave Leap IDE](https://ide.dwavesys.io/#https://github.com/klezm/QuantumAnnealingPlayground)

### Visualization

The eigenspectrum and eigenvector for this problem are visualized for different Lagrange multipliers γ:


|                   |                                                                        |               | 50 steps                                                         | 100 steps                                                         | 200 steps                                                         |
|-------------------|------------------------------------------------------------------------|---------------|------------------------------------------------------------------|-------------------------------------------------------------------|-------------------------------------------------------------------|
| Choose 2 out of 3 | Annealing Schedule starting <br> at 0 and ending at 0                  | Eigenspectrum | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of3_γ5-80_Δt50_sched-similar.html) | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of3_γ5-80_Δt100_sched-similar.html) | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of3_γ5-80_Δt200_sched-similar.html) |
|                   |                                                                        | Eigenvectors  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of3_γ5-80_Δt50_sched-similar.html)   | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of3_γ5-80_Δt100_sched-similar.html)   | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of3_γ5-80_Δt200_sched-similar.html)   |
|                   | Annealing Schedule starting <br> above 0 and ending at 0 (like D-Wave) | Eigenspectrum | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of3_γ5-80_Δt50_sched-approx.html)  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of3_γ5-80_Δt100_sched-approx.html)  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of3_γ5-80_Δt200_sched-approx.html)  |
|                   |                                                                        | Eigenvectors  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of3_γ5-80_Δt50_sched-approx.html)    | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of3_γ5-80_Δt100_sched-approx.html)    | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of3_γ5-80_Δt200_sched-approx.html)    |
| Choose 1 out of 2 | Annealing Schedule starting <br> at 0 and ending at 0                  | Eigenspectrum | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of2_γ5-80_Δt50_sched-similar.html) | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of2_γ5-80_Δt100_sched-similar.html) | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of2_γ5-80_Δt200_sched-similar.html) |
|                   |                                                                        | Eigenvectors  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of2_γ5-80_Δt50_sched-similar.html)   | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of2_γ5-80_Δt100_sched-similar.html)   | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of2_γ5-80_Δt200_sched-similar.html)   |
|                   | Annealing Schedule starting <br> above 0 and ending at 0 (like D-Wave) | Eigenspectrum | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of2_γ5-80_Δt50_sched-approx.html)  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of2_γ5-80_Δt100_sched-approx.html)  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of2_γ5-80_Δt200_sched-approx.html)  |
|                   |                                                                        | Eigenvectors  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of2_γ5-80_Δt50_sched-approx.html)    | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of2_γ5-80_Δt100_sched-approx.html)    | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of2_γ5-80_Δt200_sched-approx.html)    |
| Choose 2 out of 4 | Annealing Schedule starting <br> at 0 and ending at 0                  | Eigenspectrum | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of4_γ5-80_Δt50_sched-similar.html) | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of4_γ5-80_Δt100_sched-similar.html) | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of4_γ5-80_Δt200_sched-similar.html) |
|                   |                                                                        | Eigenvectors  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of4_γ5-80_Δt50_sched-similar.html)   | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of4_γ5-80_Δt100_sched-similar.html)   | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of4_γ5-80_Δt200_sched-similar.html)   |
|                   | Annealing Schedule starting <br> above 0 and ending at 0 (like D-Wave) | Eigenspectrum | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of4_γ5-80_Δt50_sched-approx.html)  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of4_γ5-80_Δt100_sched-approx.html)  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-choose-2of4_γ5-80_Δt200_sched-approx.html)  |
|                   |                                                                        | Eigenvectors  | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of4_γ5-80_Δt50_sched-approx.html)    | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of4_γ5-80_Δt100_sched-approx.html)    | [link](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-choose-2of4_γ5-80_Δt200_sched-approx.html)    |

Old Plots:

- Choosing Boxes Problem with 3 Boxes (pick 2 with min weight)
  - [eigenspectrums.html](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums.html)
  - [eigenspectrums3D.html](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums3D.html)
  - [eigenvectors.html](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors.html)
  - With 100 Time Steps
    - [eigenspectrums](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-dt100.html)
    - [eigenvectors](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-dt100.html)
  - With 200 Time Steps
    - [eigenspectrums](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenspectrums-dt200.html)
    - [eigenvectors](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/eigenvectors-dt200.html)
- Choosing Boxes Problem with 2 Boxes (pick the lighter one)
  - [choosing-boxes-2-eigenspectrums-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/choosing-boxes-2-eigenspectrums-dt50.html)
  - [choosing-boxes-2-eigenvectors-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/choosing-boxes-2-eigenvectors-dt50.html)
- Choosing Boxes Problem with 4 Boxes (pick 2 with min weight)
  - [choosing-boxes-4-eigenspectrums-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/choosing-boxes-4-eigenspectrums-dt50.html)
  - [choosing-boxes-4-eigenvectors-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/results/choosing-boxes-4-eigenvectors-dt50.html)
