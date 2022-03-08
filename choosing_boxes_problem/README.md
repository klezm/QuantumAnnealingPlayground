# Choosing Boxes

### Problem

The problem "Choosing Boxes" is described in the
[D-Wave problem formulation guide](https://www.dwavesys.com/media/bu0lh5ee/problem-formulation-guide-2022-01-10.pdf)
in chapt. 4.4.  
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

- Choosing Boxes Problem with 3 Boxes (pick 2 with min weight)
  - [eigenspectrums.html](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenspectrums.html)
  - [eigenspectrums3D.html](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenspectrums3D.html)
  - [eigenvectors.html](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenvectors.html)
  - With 100 Time Steps
    - [eigenspectrums](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenspectrums-dt100.html)
    - [eigenvectors](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenvectors-dt100.html)
  - With 200 Time Steps
    - [eigenspectrums](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenspectrums-dt200.html)
    - [eigenvectors](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/eigenvectors-dt200.html)
- Choosing Boxes Problem with 2 Boxes (pick the lighter one)
  - [choosing-boxes-2-eigenspectrums-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/choosing-boxes-2-eigenspectrums-dt50.html)
  - [choosing-boxes-2-eigenvectors-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/choosing-boxes-2-eigenvectors-dt50.html)
- Choosing Boxes Problem with 4 Boxes (pick 2 with min weight)
  - [choosing-boxes-4-eigenspectrums-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/choosing-boxes-4-eigenspectrums-dt50.html)
  - [choosing-boxes-4-eigenvectors-dt50](https://klezm.github.io/QuantumAnnealingPlayground/choosing_boxes_problem/choosing-boxes-4-eigenvectors-dt50.html)
