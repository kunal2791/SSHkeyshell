#########################################################

Shell script to update user public_keys

#########################################################
We have used 3 list "1" is for environment "2" is for servers under that environment "3" we have created for tc servers if we want to limit user to tc servers only. (you can modify or take example of any one)

In script we have divided it into functions and checking the user inputs to call that required Function.

The script is works in 4 options.

1. option 1 is to update the ssh key of user in all the servers listed under all environment.
2. option 2 is for update the ssh key of user in all the servers of that specific environment
3. option 3 is for database server here we have only one in our case so we just mentioned the one.
4. option 4 tc servers here we have one then one in count so created a separate list.
