echo "⚙️  Generate feature"
read -p "✅ Enter feature name: " featureName

tuist scaffold feature --name ${featureName};

#while true; do
#    read -p "✅ ${featureName} is Domain or UserInterface [Dd/Uu]: " du
#    echo "gererating .."
#    case $du in
#        [Dd]* ) tuist scaffold featureDomain --name ${featureName}; break;;
#        [Uu]* ) tuist scaffold featureUI --name ${featureName}; break;;
#        * ) echo "Please answer Domain or UserInterface.";;
#    esac
#done

echo "Create ${featurename} succeed !"
