<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<html>
<head>
    <title>Login</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Momo+Signature&display=swap" rel="stylesheet">

    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        'momo': ['"Momo Signature"', 'cursive']
                    },
                    keyframes: {
                        'fade-in-up': {
                            '0%': { opacity: '0', transform: 'translateY(10px)' },
                            '100%': { opacity: '1', transform: 'translateY(0)' },
                        },
                        'gradient-pan': {
                            '0%': { 'background-position': '0% 50%' },
                            '50%': { 'background-position': '100% 50%' },
                            '100%': { 'background-position': '0% 50%' },
                        }
                    },
                    animation: {
                        'fade-in-up': 'fade-in-up 0.5s ease-out',
                        'gradient-pan': 'gradient-pan 8s ease infinite',
                    }
                }
            }
        }
    </script>
</head>
<body class="flex min-h-screen items-center justify-center py-12 px-4
             bg-gradient-to-r from-blue-100 via-purple-100 to-pink-100
             bg-[length:400%_400%] animate-gradient-pan">

<div class="text-center w-full max-w-lg">

    <div class="w-full bg-white p-8 shadow-2xl rounded-2xl animate-fade-in-up">

        <div class="font-momo text-6xl bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent">
            Mini-Store
        </div>

        <div class="font-mono text-2xl text-gray-500 mt-2 mb-12">
            Login
        </div>

        <form id="login_form" action="login" method="post" class="space-y-3">

            <div>
                <label for="username" class="sr-only">Username</label>
                <input
                        id="username"
                        name="username"
                        type="text"
                        placeholder="Username"
                        class="font-sans text-xl w-full bg-gray-50 border border-gray-200 rounded-full px-5 py-2.5 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all duration-300"
                >
            </div>

            <div>
                <label for="password" class="sr-only">Password</label>
                <input
                        id="password"
                        name="password"
                        type="password"
                        placeholder="Password"
                        class="font-sans text-xl w-full bg-gray-50 border border-gray-200 rounded-full px-5 py-2.5 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all duration-300"
                >
            </div>

            <input
                    id="submit"
                    type="submit"
                    value="Sign in"
                    class="font-sans text-xl rounded-full px-5 py-2.5 !mt-6 bg-gradient-to-r from-blue-500 to-blue-600 text-white font-bold border-none cursor-pointer w-full shadow-lg hover:shadow-xl hover:scale-105 active:scale-95 transition-all duration-300 ease-in-out"
            >
        </form>

        <p class="mt-6 font-sans text-gray-600">
            Don't have an account?
            <a href="register" class="font-medium text-blue-500 hover:text-blue-600 transition-colors duration-150">
                Sign up
            </a>
        </p>

    </div>

    <% if("true".equals(request.getAttribute("isInvalid"))){ %>
    <div class="w-full mx-auto mt-6 bg-red-50 text-red-700 border border-red-200 font-mono text-lg p-4 rounded-xl animate-fade-in-up">
        Error : ${requestScope.Reason}
    </div>
    <%}%>

</div>

</body>
</html>