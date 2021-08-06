
# echo -e " Log name   \t      GET      \t      POST    \t   DELETE "
# echo -e "------------------------------------------------------------"

# get_requests=$(cat finance_app.log | grep "GET" | wc -l)
# post_requests=$(cat finance_app.log | grep "POST" | wc -l)
# delete_requests=$(cat finance_app.log | grep "DELETE" | wc -l)
# echo -e " Finance    \t ${get_requests}    \t    ${post_requests}   \t   ${delete_requests}"

for app in $(cat /tmp/assets/apps.txt); do
    echo -e " Log name   \t      GET      \t      POST    \t   DELETE "
    echo -e "------------------------------------------------------------"

    get_requests=$(cat /var/log/apps/${app}_app.log | grep "GET" | wc -l)
    post_requests=$(cat /var/log/apps/${app}_app.log | grep "POST" | wc -l)
    delete_requests=$(cat /var/log/apps/${app}_app.log | grep "DELETE" | wc -l)
    echo -e " $app    \t ${get_requests}    \t    ${post_requests}   \t   ${delete_requests}"
done