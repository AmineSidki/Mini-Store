<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<html>
<head>
    <title>Page Not Found</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Momo+Signature&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { 'momo': ['"Momo Signature"', 'cursive'] },
                    keyframes: {
                        'float': {
                            '0%, 100%': { transform: 'translateY(0)' },
                            '50%': { transform: 'translateY(-20px)' },
                        },
                        'gradient-pan': {
                            '0%': { 'background-position': '0% 50%' },
                            '50%': { 'background-position': '100% 50%' },
                            '100%': { 'background-position': '0% 50%' },
                        }
                    },
                    animation: {
                        'float': 'float 6s ease-in-out infinite',
                        'gradient-pan': 'gradient-pan 8s ease infinite',
                    }
                }
            }
        }
    </script>
</head>
<body class="flex min-h-screen items-center justify-center p-4
             bg-gradient-to-r from-blue-100 via-purple-100 to-pink-100
             bg-[length:400%_400%] animate-gradient-pan overflow-hidden">

<div class="text-center max-w-lg w-full">

    <!-- Big Animated 404 Text -->
    <div class="font-momo text-[150px] leading-none text-blue-500/20 select-none animate-float absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 -z-10">
        404
    </div>

    <!-- Glass Card -->
    <div class="bg-white/80 backdrop-blur-md p-8 rounded-3xl shadow-2xl border border-white/50 relative z-10">

        <div class="mb-6">
            <svg class="w-20 h-20 mx-auto text-blue-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>
            <h1 class="font-momo text-5xl text-gray-800 mb-2">Lost in the Aisles?</h1>
            <p class="font-mono text-gray-500 text-lg">
                We looked everywhere, but the product (or page) you are looking for is out of stock.
            </p>
        </div>

        <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <!-- Go Back Button -->
            <button onclick="history.back()" class="px-6 py-3 rounded-xl bg-gray-100 text-gray-600 font-bold hover:bg-gray-200 transition-colors">
                Go Back
            </button>

            <!-- Home Button -->
            <a href="${pageContext.request.contextPath}/products" class="px-6 py-3 rounded-xl bg-gradient-to-r from-blue-500 to-blue-600 text-white font-bold shadow-lg hover:shadow-blue-500/30 hover:scale-105 transition-all">
                Back to Store
            </a>
        </div>
    </div>

</div>

</body>
</html>