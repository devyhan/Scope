echo "⚙️  Bootstrapping.."

curl -Ls https://install.tuist.io | bash
echo "⚙️  Fetching third party library dependencies.."
tuist fetch
echo "⚙️  Generate project"
tuist generate

echo "Succeed !"
