## Allow password to be changed at login for the notebook server.
#  
#  While loggin in with a token, the notebook server UI will give the opportunity
#  to the user to enter a new password at the same time that will replace the
#  token login mechanism.
#  
#  This can be set to false to prevent changing password from the UI/API.
c.NotebookApp.allow_password_change = False

## The directory to use for notebooks and kernels.
c.NotebookApp.notebook_dir = '/data'

#  
#  Setting to an empty string disables authentication altogether, which is NOT
#  RECOMMENDED.
c.NotebookApp.token = 'your token'

## If True (default), deleting files will send them to the platform's
#  trash/recycle bin, where they can be recovered. If False, deleting files
#  really deletes them.
c.FileContentsManager.delete_to_trash = False

