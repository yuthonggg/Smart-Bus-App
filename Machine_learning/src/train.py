# bus_occupancy_regression.py

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.metrics import mean_squared_error, r2_score
import tensorflow as tf
from tensorflow.keras import layers, models

# ==========================
# 1. Load Dataset
# ==========================
# Example CSV columns:
# bus_occupancy, station_occupancy, location, hour_of_day, day_of_week, future_occupancy
data = pd.read_csv("Data/bus_dataset.csv")

# Features and target
X = data.drop("future_occupancy", axis=1)
y = data["future_occupancy"]

# ==========================
# 2. Preprocess Data
# ==========================
numeric_features = ["bus_occupancy", "station_occupancy", "hour_of_day"]
categorical_features = ["location", "day_of_week"]

# Preprocessing pipeline
preprocessor = ColumnTransformer([
    ("num", StandardScaler(), numeric_features),
    ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_features)
])

# Fit and transform
X_processed = preprocessor.fit_transform(X)

# Save feature names for later use
# This helps if you need to understand the encoded columns
feature_names = (
    numeric_features +
    list(preprocessor.named_transformers_["cat"].get_feature_names_out(categorical_features))
)

# ==========================
# 3. Train/Test Split
# ==========================
X_train, X_test, y_train, y_test = train_test_split(
    X_processed, y, test_size=0.2, random_state=42
)

# ==========================
# 4. Build Model
# ==========================
model = models.Sequential([
    layers.Input(shape=(X_train.shape[1],)),
    layers.Dense(64, activation="relu"),
    layers.Dense(32, activation="relu"),
    layers.Dense(16, activation="relu"),
    layers.Dense(1, activation="linear")  # Regression output
])

model.compile(optimizer="adam", loss="mse", metrics=["mae"])

# ==========================
# 5. Train Model
# ==========================
history = model.fit(
    X_train, y_train,
    validation_split=0.2,
    epochs=50,
    batch_size=32,
    verbose=1
)

# ==========================
# 6. Evaluate Model
# ==========================
y_pred = model.predict(X_test).flatten()

rmse = np.sqrt(mean_squared_error(y_test, y_pred))
r2 = r2_score(y_test, y_pred)

print(f"RMSE: {rmse:.2f}")
print(f"R²: {r2:.3f}")

# ==========================
# 7. Map Predictions into Categories
# ==========================
def occupancy_category(value):
    if value < 40:
        return "Low"
    elif value < 70:
        return "Medium"
    else:
        return "High"

y_pred_categories = [occupancy_category(v) for v in y_pred]

print("Sample predictions with categories:")
for true_val, pred_val, cat in zip(y_test[:10], y_pred[:10], y_pred_categories[:10]):
    print(f"True: {true_val:.1f}, Pred: {pred_val:.1f} -> {cat}")

# ==========================
# 8. Save Model
# ==========================
model.save("bus_occupancy_model.h5")
print("Model saved to bus_occupancy_model.h5")
