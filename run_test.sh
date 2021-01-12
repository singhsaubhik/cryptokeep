echo "Checking formatting..."
flutter format --set-exit-if-changed .

# Adding new line.
echo
echo

echo "Analyzing static dart code..."
flutter analyze .

echo
echo

echo "Running flutter test..."
flutter test