import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 4 * np.pi, 500)
y = np.sin(x)

plt.figure(figsize=(8, 4))
plt.plot(x, y, linewidth=2)
plt.title("Sine Wave")
plt.xlabel("x")
plt.ylabel("sin(x)")
plt.grid(True)
plt.tight_layout()
plt.savefig("gallery/plot.png", dpi=150)
plt.close()
