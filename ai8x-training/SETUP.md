# Project Setup Instructions

This guide walks through the setup process for the AI8X training environment on Windows with CUDA 11 support. Following these steps in order is crucial to avoid common dependency conflicts.

---

## âš™ï¸ Installation

### 1. Prerequisites
- **Install Python 3.9.x**. During installation, ensure you check the box that says **"Add Python 3.9 to PATH"**.
- **Install Git for Windows** from the [official website](https://git-scm.com/download/win).

### 2. Initial Repository Setup
1.  **Clone the Repository**: Open a terminal (like Git Bash) and clone the project repository, making sure to include the `distiller` submodule.
    ```bash
    git clone --recursive [https://github.com/wiwiwinter/ai8x-training-catsdogs.git](https://github.com/wiwiwinter/ai8x-training-catsdogs.git)
    cd ai8x-training-catsdogs
    ```

2.  **Create and Activate Virtual Environment**: This isolates the project's dependencies.
    ```bash
    python -m venv venv
    .\venv\Scripts\activate
    ```

### 3. Install Python Dependencies
The order of installation is **critical** to prevent version conflicts.

1.  **Install NumPy First**: This project requires a specific version of NumPy that is compatible with an older version of PyTorch.
    ```bash
    pip install numpy==1.22.4
    ```

2.  **Install PyTorch**: Install the PyTorch wheels that are compiled for Python 3.9 (`cp39`) and CUDA 11.1 (`cu111`).
    ```bash
    pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 -f [https://download.pytorch.org/whl/torch_stable.html](https://download.pytorch.org/whl/torch_stable.html)
    ```

3.  **Install Remaining Packages**: Now, install the rest of the required packages.
    ```bash
    pip install -r requirements-win-cu11.txt
    ```

### 4. Install the Distiller Submodule
Finally, navigate into the `distiller` directory and install it in editable mode. The `--no-deps` flag is essential to prevent it from overwriting our carefully selected packages.
```bash
cd distiller
pip install -e . --no-deps
cd ..
```

---

## âš ï¸ Common Issues & Solutions

-   **Issue 1: "puccinialin not found"**
    -   **Cause**: Old build packages that are incompatible with Python 3.9+.
    -   **Solution**: This is already fixed in the project's `requirements` files, which specify compatible package versions.

-   **Issue 2: "numpy 1.17.3 build failed"**
    -   **Cause**: `torchnet` or `scikit-learn` try to install an old, incompatible version of `numpy`.
    -   **Solution**: Manually install `numpy==1.22.4` **before** running `pip install -r requirements-win-cu11.txt`.

-   **Issue 3: "Image.ANTIALIAS not found"**
    -   **Cause**: `Pillow` version 10 and newer removed the `Image.ANTIALIAS` attribute.
    -   **Solution**: The requirements file pins `Pillow` to a version between 7 and 10 (`"Pillow>=7,<10"`).

-   **Issue 4: "NumPy 2.0 incompatible with PyTorch"**
    -   **Cause**: A dependency like `matplotlib` automatically upgrades `numpy` to an incompatible 2.x version.
    -   **Solution**: The requirements file pins `numpy==1.22.4` and `matplotlib<3.8` to prevent this.

-   **Issue 5: Submodule changes are not committing**
    -   **Cause**: `distiller` is a separate Git repository nested inside the main project.
    -   **Solution**: You must commit changes inside `distiller` first (`cd distiller`, `git add`, `git commit`), then go back to the main project to commit the updated submodule reference (`cd ..`, `git add distiller`, `git commit`).

---

## í³¦ Critical Package Versions

This setup relies on the careful balancing of the following key packages:

| Package | Version | Reason for Specific Version |
| :--- | :--- | :--- |
| **Python** | `3.9.x` | Required for the specific PyTorch `cp39` wheels and modern package support. |
| **numpy** | `1.22.4` | Compatible with PyTorch `1.8.1` and other packages like `numba`. |
| **torch** | `1.8.1+cu111` | Specific version with CUDA 11.1 support compiled for Python 3.9. |
| **numba** | `0.55.2` | Compatible with `numpy==1.22.4`. |
| **Pillow** | `>=7,<10` | Avoids the `ANTIALIAS` deprecation error found in Pillow 10+. |
| **matplotlib** | `>=3.3,<3.8` | Prevents `numpy` from being upgraded to an incompatible 2.x version. |
| **scikit-learn**| `1.6.1` | Modern, compatible version (the `distiller` check for an older version is ignored). |

---

## âœ… Success Checklist

-   [ ] Python 3.9 is installed and correctly configured in your system's PATH.
-   [ ] A virtual environment (`venv`) was successfully created and activated.
-   [ ] `numpy==1.22.4` was installed **first**.
-   [ ] The correct PyTorch `cp39` wheels for CUDA 11.1 were installed.
-   [ ] The `distiller` submodule was installed with the `--no-deps` flag.
-   [ ] The training script (`./scripts/train_catsdogs.sh`) runs without import errors.
-   [ ] The first training epoch completes successfully.
-   [ ] Your project changes have been committed with `git commit`.
-   [ ] Your branch has been pushed to your GitHub repository with `git push`.
-   [ ] This setup documentation has been created and committed.

---

## íº€ Next Steps

1.  **Train Your Model**: Execute the training script and let it run to completion.
    ```bash
    ./scripts/train_catsdogs.sh
    ```
2.  **Monitor Progress**: Visualize training metrics using TensorBoard.
    ```bash
    tensorboard --logdir logs
    ```
3.  **Adjust Hyperparameters**: Modify `scripts/train_catsdogs.sh` to experiment with the learning rate, batch size, or other settings.
4.  **Export Model**: Use the quantization scripts to prepare your trained model for deployment on target hardware.

---

## í³š Resources

-   **Python 3.9 Download**: [https://www.python.org/downloads/release/python-3913/](https://www.python.org/downloads/release/python-3913/)
-   **PyTorch Wheels Archive**: [https://download.pytorch.org/whl/torch_stable.html](https://download.pytorch.org/whl/torch_stable.html)
-   **TensorBoard Quickstart Guide**: [https://www.tensorflow.org/tensorboard/get_started](https://www.tensorflow.org/tensorboard/get_started)
