
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--TODO: If some changes have been made but the user is trying to leave this page,
          display a confirmation window to not save changes--%>
<html>
<head>
    <title>MUIC Talk</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../styles/styles.css">
</head>
<body>
<div class="container mt-4">
    <nav class="navbar navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand"><strong>MUIC Talk</strong></a>
            <div>
                <a class="btn btn-primary" type="button" href="/"><i class="fa fa-home"></i> &nbsp; Home </a>
                <a class="btn btn-primary" type="button" href="/"><i class="fa fa-calendar"></i> &nbsp; Schedule </a>
                <a class="btn btn-primary" type="button" href="/chat"><i class="fa fa-comments"></i> &nbsp; Chats </a>
            </div>
            <div>
                <a class="btn btn-primary btn-w40" type="button" href="/logout"><i class="fa fa-sign-out"></i></a>
            </div>
        </div>
    </nav>
    <div class="row justify-content-md-center">
        <div class="col col-sm-12  col-md-6 mt-5 mb-4">
            <h2 class="text-center mb-4">Account Settings</h2>
            <p>${error}</p> <%-- Error, if any --%>
            <div class="container-fluid md-4">
                <div class="user-profile pull-left" style="column-gap: 20px;">
                    <img src="../Images/default_img.png" class="circle" style="height: 160px; width: 160px;" alt="User profile picture">
                    <h4><strong>${displayName}</strong> <br> ${username}</h4>
                </div>
            </div>
        </div>
        <div class="row justify-content-md-center">
            <div class="col col-sm-12  col-md-6">
                <c:if test="${not empty message}">
                    <c:choose>
                        <c:when test="${hasError}">
                            <div class="alert alert-danger" role="alert">
                                    ${message}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-success" role="alert">
                                    ${message}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </div>
        <div class="row justify-content-md-center">
            <div class="container col col-sm-12 col-md-6 mb-4">
                <div class="container-fliud">
                    <a class="btn btn-primary" type="button" href="/"><i class="fa fa-user"></i> General Settings</a>
                    <a class="btn btn-primary" type="button" href="/"><i class="fa fa-key"></i> Change Password</a>
                </div>
            </div>
        </div>
        <div class="row justify-content-md-center">
            <div class="container col col-sm-12 col-md-6 mb-4">
                <form action="/user/edit?username=${username}" method="post">
                    <div class="input-group mb-4 input-group-md">
                        <span class="input-group-text" id="displayName" style="width: 40px"><i class="fa fa-user"></i></span>
                        <input type="text" class="form-control py-2"
                               name="displayName" placeholder="Display Name"
                               aria-label="Display Name" aria-describedby="displayName"
                               autocomplete="off" value="${displayName}">
                    </div>
                    <div class="d-grid gap-2">
                        <button class="btn btn-primary" type="submit"><i class="fa fa-save"></i> &nbsp; Save</button>
                    </div>
                </form>
            </div>
            <div class="container col col-sm-12 col-md-6 mb-4" style="display: none;">
                <form action="/user/password?username=${username}" method="post">
                    <div class="input-group mb-4 input-group-md">
                        <span class="input-group-text" id="password" style="width: 40px"><i class="fa fa-key"></i></span>
                        <input type="password" class="form-control py-2"
                               name="password" placeholder="Password"
                               aria-label="Password" aria-describedby="password"
                               autocomplete="off" value="${password}">
                    </div>
                    <div class="input-group mb-4 input-group-md">
                        <span class="input-group-text" id="confirmPassword" style="width: 40px"><i class="fa fa-key"></i></span>
                        <input type="password" class="form-control py-2"
                               name="confirmPassword" placeholder="Confirm Password"
                               aria-label="Confirm Password" aria-describedby="confirmPassword"
                               autocomplete="off" value="${confirmPassword}">
                    </div>
                </form>
            </div>
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