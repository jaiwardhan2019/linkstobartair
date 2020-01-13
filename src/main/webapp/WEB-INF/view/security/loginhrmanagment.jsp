<!DOCTYPE html>
<html>
<head>
    <title>Cascade HR</title>
    <link rel="stylesheet" href="https://StobartAir.cascadecloud.co.uk/Custom/STOBARTAIR/style/STOBARTAIR/cascadestyle.css" />
    <link rel="stylesheet" href="logon.css" />
    <style>
        main { background-image: url('https://StobartAir.cascadecloud.co.uk/Custom/STOBARTAIR/backdrop/STOBARTAIR/login_backdrop.jpg') }
    </style>
</head>
<body>
    <iframe src="dotnet/ClearDotNetSession.aspx" style="display:none"></iframe>

    <main>
        <form method="post" action="https://stobartair.cascadecloud.co.uk/logon_funct.asp" name="loginform" autocomplete="off">
            <div class="row">
                
                    <input type="hidden" name="COMPANY" value="StobartAir" /> &nbsp;
                
            </div>
            <div class="row">
                <label for="USERID" accesskey="u">Username</label>
                <input name="User ID" id="USERID" value="${USERID}" />
            </div>
            <div class="row">
                <label for="PWD" accesskey="p">Password</label>
                <input name="Password" id="PWD"  type="password" value="${PWD}"/>
            </div>
            <div class="row">
                <span>(password is case sensitive)</span>
            </div>
            <div class="row">
                <button type="submit" id="LOGINBUTTON">Logon</button>
            </div>
            <div class="row">
                
                <a title="Retrieve your password" href="javascript:forgottenPassword();">I&rsquo;ve forgotten my password</a>
                
            </div>
            <footer>
                Cascade v5.54.0
            </footer>
        </form>
        
        <div id="loading-background" style="display:none">
            <img src="images/wait_animation.gif" alt="Loading…" />
        </div>
    </main>

    
    <div style="position: absolute; top: 25px; left: 245px; border: 1px solid firebrick;
        background-color: linen; padding: 5px; display:none">
        <table width="500px">
            <tr>
                <td align="center">
                    <b>[TITLE]</b>
                </td>
            </tr>
            <tr>
                <td align="center">
                [MESSAGE] 
                </td>
            </tr>
        </table>
    </div>
    

    <script>
        var form = document.querySelector("form");
        var loader = document.getElementById("loading-background");

        form.onsubmit = function (e) {
            loader.style.display = "flex";
        };

        function forgottenPassword() {
            var bProceed = true;

            if (document.getElementById("USERID").value === "") {
                bProceed = false;
            }

            if (bProceed) {
                loginform.action = "dotnet/framework/PasswordReset.aspx?CompanyName=" + loginform.COMPANY.value;
                loginform.submit();
            } else if (loginform.COMPANY.type === "password") {
                alert("In order to reset your password, please enter your company and username.");
            } else {
                alert("In order to reset your password, please enter your username.")
            };
        }
    </script>
    
        <script type="text/javascript">
            document.loginform.submit();
    </script>
    
    
</body>
</html>