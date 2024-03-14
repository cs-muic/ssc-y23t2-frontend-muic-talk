<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Webapp</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        body {
            position: relative;
            min-height: 100vh;
        }
        body::before {
            content: "";
            background-image: url("../Images/41_MUIC_campus.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            filter: blur(5px); /* Adjust the blur value as needed */
            z-index: -1;
        }

        .container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.7); /* White with 70% opacity */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* Shadow for better visibility */
        }
        .btn-primary {
            background-color: #6a0dad;
            border-color: #6a0dad;
        }
        .btn-primary:hover {
            background-color: #550a8a;
            border-color: #550a8a;
        }

        .logo-container {
            position: absolute;
            top: 20px;
            left: 20px;
            z-index: 999;
        }
        .logo-container img {
            width: 150px;
            height: auto;
        }
        .form-title {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .form-title img {
            width: 50px;
            height: auto;
            margin-right: 10px;
        }


        .webapp-logo {
            display: flex;
            align-items: center; /* Align items vertically */
        }
        .webapp-logo > div:first-child {
            margin-right: 20px; /* Adjust margin as needed */
        }
        .webapp-logo img {
            width: 80px;
            height: auto;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>
</head>

<body>
<!-- MUIC Logo -->
<div class="logo-container">
    <img src="../Images/MUIC_Logo.png" alt="MUIC Logo">
</div>


<!-- Sign Up Form -->
<div class="container" style="display: none;">

    <%--    <c:if test="${not empty message}">--%>
    <%--        <c:choose>--%>
    <%--            <c:when test="${hasError}">--%>
    <%--                <div class="alert alert-danger" role="alert">--%>
    <%--                        ${error}--%>
    <%--                </div>--%>
    <%--            </c:when>--%>
    <%--            <c:otherwise>--%>
    <%--                <div class="alert alert-success" role="alert">--%>
    <%--                        ${message}--%>
    <%--                </div>--%>
    <%--            </c:otherwise>--%>
    <%--        </c:choose>--%>
    <%--    </c:if>--%>

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
            <div>Already have an account? <a href="/login">Login</a> </div>
        <%--            <div class="mt-3">Already have an account? <a href="#">Login</a></div>--%>
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
</script>

</body>

</html>