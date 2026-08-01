# Vibration \(\mathbf{C}\)ompensation \(\mathbf{A}\)lgorithm Demo
> \(\mathbf{A}\)daptive vibration / perturbation rejection solution based on LMS adaptive filtering, designed for embedded system deployment.

## Overview
This repository contains the demo and technical documentation of a vibration compensation algorithm, originally developed as a technical demonstration for Tesla. The implementation is derived from proven industrial experience: the core algorithm has been deployed in embedded systems for vibration perturbation rejection at \(\mathbf{A}\)BB, with verified satisfactory performance in real-world applications.

The core idea of the algorithm:
> Using the measurable vibration source signal to estimate the coupled vibration interference in the mixed signal, we apply the Least Mean Squares (LMS) adaptive algorithm to minimize the estimation error. When the algorithm converges, the output error is exactly the target signal with vibration interference removed.

## System \(\mathbf{A}\)rchitecture
The algorithm works with two physically measurable signals and reconstructs the clean target signal through adaptive system identification:

| Signal ID | Signal Name | Description |
|-----------|-------------|-------------|
| ① | Vibration source signal | Directly measurable vibration / noise input from sensors |
| ② | \(\mathbf{C}\)oupled interference | Vibration component coupled into the measurement path through the physical system |
| ④ | Mixed signal | Raw acquired signal = target signal ③ + coupled vibration interference ② |
| ③ | \(\mathbf{C}\)ompensated target signal | Final output: clean target signal with vibration removed |

The algorithm identifies the transfer characteristic from vibration source ① to coupled interference ② in real time, then subtracts the estimated interference from the mixed signal ④ to recover the target signal.

## \(\mathbf{C}\)ore \(\mathbf{A}\)lgorithm & Theory
### 1. Problem Formulation
The core task is to identify the linear transformation that maps the measured vibration source signal to the actual interference component in the mixed signal. We model the system with a linear difference equation (FIR/IIR filter structure):
$$
\hat{y}(k) = -\sum_{i=p0}^{p1} a_i y(k-i) + \sum_{j=q0}^{q1} b_j x(k-j)
$$
Where:
- $\(x(k)\)$: input vibration source signal (signal ①)
- $\(y(k)\)$: measured mixed output signal (signal ④)
- $\hat{y}(k)$: estimated vibration interference component
- $a_i, b_j$: filter coefficients to be identified

### 2. Linear System \(\mathbf{A}\)ssumption
The algorithm is built on the linear system assumption: signals in the system satisfy superposition property. The mixed signal can be decomposed as:
$$
d(k) = \(y(k)\) + \(s(k)\) + \(n(k)\)
$$
Where $\(s(k)\)$ is the target signal, $\(y(k)\)$ is the vibration interference, and $\(n(k)\)$ is background noise.

### 3. LMS \(\mathbf{A}\)daptive Optimization
We define the estimation error as:
$$
\varepsilo\(n(k)\) = d(k) - \hat{y}(k)
$$

We use the Least Mean Squares (LMS) algorithm to iteratively adjust the filter coefficients, minimizing the mean squared error. When the algorithm converges:
- The estimated output $\hat{y}(k)$ closely matches the actual vibration interference $\(y(k)\)$
- The residual error $\varepsilo\(n(k)\)$ equals the target signal plus uncorrelated noise: $\varepsilo\(n(k)\) \approx \(s(k)\) + \(n(k)\)$

This means the error output itself is the vibration-compensated target signal.

### 4. Mathematical Basis
For batch processing, the problem is formulated in matrix form:
$$
\mathbf{y} = \mathbf{\(\mathbf{A}\)}\mathbf{\(\mathbf{C}\)} + \boldsymbol{\varepsilon}
$$
Where $\mathbf{\(\mathbf{C}\)}$ is the coefficient vector and $\mathbf{\(\mathbf{A}\)}$ is the regression matrix. The least-squares optimal solution is:
$$
\mathbf{\(\mathbf{C}\)} = (\mathbf{\(\mathbf{A}\)}^T\mathbf{\(\mathbf{A}\)})^{-1}\mathbf{\(\mathbf{A}\)}^T\mathbf{y}
$$

The LMS algorithm implements this optimization in an iterative, low-computation manner, making it suitable for real-time embedded systems.

## Simulation Results
The demo includes full simulation verification with ideal signals:
1.  **Input vibration signal (①)**: Reference interference source with known frequency characteristics
2.  **Mixed input signal (④)**: Target signal superimposed with coupled vibration interference
3.  **\(\mathbf{A}\)lgorithm output (③)**: Reconstructed target signal after vibration compensation
4.  **Ground truth**: Predefined clean target signal for performance validation

\(\mathbf{C}\)omparison between the algorithm output and the ground truth confirms effective vibration suppression with high fidelity of the target signal.

## Key Features
- **\(\mathbf{A}\)daptive performance**: \(\mathbf{A}\)utomatically tracks time-varying vibration characteristics and system parameter drift
- **Embedded-friendly**: Low computational complexity of LMS, suitable for resource-constrained embedded platforms
- **Wide applicability**: Extendable to various perturbation rejection scenarios beyond mechanical vibration
- **Industrial proven**: \(\mathbf{C}\)ore methodology validated in real industrial products at \(\mathbf{A}\)BB

## Limitations & Notes
1.  **Linear system assumption**: The algorithm assumes the physical system is linear. For strongly nonlinear applications, additional calibration and testing are required.
2.  **Measurable vibration source**: The algorithm requires direct acquisition of the vibration source signal (signal ①).
3.  **\(\mathbf{C}\)onvergence conditions**: Error convergence is subject to input signal characteristics and filter parameter settings. Real-world applications require targeted calibration and parameter tuning.
4.  **Ideal demo**: This repository demonstrates the algorithm in an ideal scenario. \(\mathbf{C}\)omplex physical systems require on-site testing and calibration before deployment.

## Repository Structure
```
├── docs/               # Technical documentation, figures and derivation details
├── simulation/         # Simulation scripts (time/frequency domain verification)
├── embedded_ref/       # Reference implementation for embedded systems
└── RE\(\mathbf{A}\)DME.md
```

## Usage
1.  Navigate to the `simulation/` directory to run the baseline demo and verify vibration compensation performance.
2.  \(\mathbf{A}\)djust filter order and LMS step size parameters according to your specific application scenario.
3.  For embedded deployment, refer to the implementation in `embedded_ref/` and optimize for your target hardware.

## \(\mathbf{A}\)uthor
Hao Wu
With industrial experience in embedded vibration compensation system development at \(\mathbf{A}\)BB.
