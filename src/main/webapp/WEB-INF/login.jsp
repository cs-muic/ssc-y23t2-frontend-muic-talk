<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>MUIC Talk</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../styles/styles.css">
    <link rel="stylesheet" href="../styles/login-styles.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
</head>

<body>
<!-- MUIC Logo -->
<div class="logo-container">
    <img src="../Images/MUIC_Logo.png" alt="MUIC Logo">
</div>
<!-- Login Form -->
<div class="container">

    <c:if test="${not empty message}">
        <div class="alert alert-danger" role="alert">
            Failed to Sign Up: ${message}
        </div>
    </c:if>

    <div class="row justify-content-md-center h-100">
        <div class="col-sm-12 col-md-4 my-auto">
            <div class="form-title">
                <div class="webapp-logo">
                    <div>
                        <img src="../Images/MuicTALK_Logo.png" alt="Webapp Logo">
                    </div>
                    <div>
                        <h2>Login</h2>
                    </div>
                </div>
            </div>
            <p>${error}</p>
            <form action="/login" method="post">
                <!-- Username -->
                <div class="input-group mb-4 input-group-md">
                    <span class="input-group-text" id="login-username" style="width:40px">
                        <i class="fa fa-user"></i>
                    </span>
                    <input type="text" class="form-control" name="username" placeholder="uXXXXXXX"
                           aria-label="Username" aria-describedby="login-username">
                </div>
                <!-- Password -->
                <div class="input-group mb-4 input-group-md">
                    <span class="input-group-text" id="login-password" style="width:40px">
                        <i class="fa fa-key"></i>
                    </span>
                    <input type="password" class="form-control" name="password" placeholder="Password"
                           aria-label="Password" aria-describedby="login-password">
                </div>
                <!-- Login Button -->
                <div class="d-grid gap-2">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-sign-in"></i>&nbsp;Login</button>
                </div>
            </form>
            <!-- Link to Sign Up -->
            <div class="mt-3">Don't have an account? <a href="#">Sign Up</a></div>
        <%--            <div class="mt-3">Don't have an account? <a href="/user/create">Sign Up</a></div>--%>
        </div>
    </div>
</div>

<!-- Sign Up Form -->
<div class="container" style="display: none;">

    <c:if test="${not empty message}">
        <div class="alert alert-danger" role="alert">
                Failed to Sign Up: ${message}
        </div>
    </c:if>

    <div class="row justify-content-md-center h-100">
        <div class="col-sm-12 col-md-4 my-auto">
            <div class="form-title">
                <div class="webapp-logo">
                    <div>
                        <img src="../Images/MuicTALK_Logo.png" alt="Webapp Logo">
                    </div>
                    <div>
                        <h2>Sign Up</h2>
                    </div>
                </div>
            </div>
            <p>${error}</p>
            <form action="/user/create" method="post">
                <!-- Username -->
                <div class="input-group mb-4 input-group-md">
                    <span class="input-group-text" id="signup-username" style="width:40px">
                        <i class="fa fa-user"></i>
                    </span>
                    <input type="text" class="form-control" name="username" placeholder="Username"
                           aria-label="Username" aria-describedby="signup-username" autocomplete="off" value="${username}" required>
                </div>
                <!-- Display Name -->
                <div class="input-group mb-4 input-group-md">
                    <span class="input-group-text" id="signup-displayName" style="width:40px">
                        <i class="fa fa-user"></i>
                    </span>
                    <input type="text" class="form-control" name="displayName" placeholder="Display Name"
                           aria-label="DisplayName" aria-describedby="signup-displayName" autocomplete="off" value="${displayName}" required>
                </div>
                <!-- Password -->
                <div class="input-group mb-4 input-group-md">
                    <span class="input-group-text" id="signup-password" style="width:40px">
                        <i class="fa fa-key"></i>
                    </span>
                    <input type="password" class="form-control" name="password" placeholder="Password"
                           aria-label="password" aria-describedby="signup-password" autocomplete="off" value="${password}" required>
                </div>
                <!-- Confirmed Password -->
                <div class="input-group mb-4 input-group-md">
                    <span class="input-group-text" id="signup-cpassword" style="width:40px">
                        <i class="fa fa-key"></i>
                    </span>
                    <input type="password" class="form-control" name="confirm-password" placeholder="Confirm Password"
                           aria-label="Password" aria-describedby="signup-cpassword" autocomplete="off" required>
                </div>
                <!-- Sign Up Button -->
                <div class="d-grid gap-2">
                    <button class="btn btn-primary" type="submit"><i class="fa fa-user-plus"></i>&nbsp;Sign Up</button>
                </div>
            </form>
            <!-- Link to Login -->
            <div class="mt-3">Already have an account? <a href="#">Login</a></div>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('a[href="#"]').forEach(link => {
        link.addEventListener('click', () => {
            document.querySelectorAll('.container').forEach(container => {
                container.style.display = container.style.display === 'none' ? '' : 'none';
            });
        });
    });

    // Ensure the error message is displayed even if the sign-up form is hidden
    const errorMessage = document.querySelector('.container.error .alert-danger');
    if (errorMessage) {
        errorMessage.style.display = 'block';
    }
</script>

</body>

</html>