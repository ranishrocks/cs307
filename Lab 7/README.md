## Problem 1: Binary Bandit

**Problem Description:**

Consider a binary bandit with two possible rewards: `1` (success) and `0` (failure). The bandit returns either `1` or `0` for the action you select (action `1` or `2`). The rewards are stochastic but stationary. The goal is to use the epsilon-greedy algorithm to decide the optimal action that maximizes the expected reward.

**Approach:**

This is a classic case of a 2-armed bandit, where the rewards are binary (`1` for success, `0` for failure). We employed the epsilon-greedy algorithm to balance exploration and exploitation. 

- A random number between 0 and 1 is generated. If the number is greater than epsilon, we perform **exploitation**, selecting the action with the highest estimated reward (Q-value).
- If the random number is less than epsilon, we perform **exploration**, selecting a random action to gather new information.

**Results:**

Action `A` vs Action `B`

| A | B |
|---|---|
| ![image](https://github.com/user-attachments/assets/a5b7509b-9aae-433b-8043-0aab52db6964) | ![image](https://github.com/user-attachments/assets/0b4235e9-873b-4c55-8097-ea2e03f84d2c) |

---

## Problem 2: 10-Armed Bandit with Random Walk

**Problem Description:**

Develop a 10-armed bandit where all ten mean rewards start out equal. These mean rewards then take independent random walks, where at each time step, a normally distributed increment (mean zero, standard deviation 0.01) is added to each reward.

**Approach:**

In this case, the rewards are non-stationary, as each action’s mean reward evolves over time. The initial mean-reward array is set to 1 for all arms, and at every iteration, we update the mean-reward array by adding a normally distributed increment with mean 0 and standard deviation 0.01.

The epsilon-greedy algorithm is applied here, where:
- We exploit based on prior knowledge if the random number is greater than epsilon.
- Otherwise, we explore new actions.

Each action produces a reward based on the updated mean-reward array at every time step.

**Results:**

10-Armed Bandit Visualization:

![image](https://github.com/user-attachments/assets/c97adb15-b8b2-43ef-b413-44c52f002331)

---

## Problem 3: Modified Epsilon-Greedy for Non-Stationary Rewards

**Problem Description:**

The 10-armed bandit with non-stationary rewards (as developed in Problem 2) is challenging for a standard epsilon-greedy algorithm. To handle this, we modify the epsilon-greedy algorithm to track non-stationary rewards more effectively.

**Approach:**

Instead of using a simple averaging method to update the action-reward estimations, we assign more weight to the most recent rewards using an alpha parameter (`α = 0.7`). This ensures that the agent adapts quickly to the changing rewards in the non-stationary environment.

**Results:**

Performance of the modified epsilon-greedy algorithm:

![image](https://github.com/user-attachments/assets/01dccb3d-ca16-4fb1-bb64-2cfa4fafd602)
