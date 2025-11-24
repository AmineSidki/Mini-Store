<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<html>
<head>
    <title>Internal Server Error</title>

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
                        'shake': {
                            '0%, 100%': { transform: 'translateX(0)' },
                            '10%, 30%, 50%, 70%, 90%': { transform: 'translateX(-4px)' },
                            '20%, 40%, 60%, 80%': { transform: 'translateX(4px)' },
                        },
                        'gradient-pan': {
                            '0%': { 'background-position': '0% 50%' },
                            '50%': { 'background-position': '100% 50%' },
                            '100%': { 'background-position': '0% 50%' },
                        }
                    },
                    animation: {
                        'shake': 'shake 0.5s ease-in-out',
                        'gradient-pan': 'gradient-pan 8s ease infinite',
                    }
                }
            }
        }
    </script>
</head>
<body class="flex min-h-screen items-center justify-center p-4
             bg-gradient-to-r from-red-50 via-orange-50 to-red-50
             bg-[length:400%_400%] animate-gradient-pan">

<div class="w-full max-w-xl">

    <!-- Main Card -->
    <div class="bg-white p-8 rounded-3xl shadow-2xl border-l-4 border-red-400 animate-shake">

        <div class="text-center mb-8">
            <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4 text-red-500">
                <svg class="w-10 h-10" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg>
            </div>

            <h1 class="font-momo text-5xl text-gray-800 mb-2">Cleanup on Aisle 500</h1>
            <p class="font-mono text-gray-500 text-lg">
                Something went wrong on our end. Our developers have been notified.
            </p>
        </div>

        <!-- Action Buttons -->
        <div class="flex justify-center gap-4 mb-8">
            <a href="${pageContext.request.contextPath}/products" class="px-6 py-3 rounded-xl bg-gray-800 text-white font-bold hover:bg-gray-700 transition-colors shadow-lg">
                Return to Store
            </a>
        </div>

        <!-- Technical Details (Collapsible) -->
        <div class="border-t border-gray-100 pt-4">
            <details class="group">
                <summary class="flex justify-between items-center font-medium cursor-pointer list-none text-gray-400 hover:text-red-500 transition-colors text-sm">
                    <span>Show Technical Details</span>
                    <span class="transition group-open:rotate-180">
                            <svg fill="none" height="24" shape-rendering="geometricPrecision" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" viewBox="0 0 24 24" width="24"><path d="M6 9l6 6 6-6"></path></svg>
                        </span>
                </summary>
                <div class="text-gray-600 mt-3 group-open:animate-fadeIn">
                    <div class="bg-gray-50 p-4 rounded-lg overflow-x-auto border border-gray-200">
                        <p class="text-red-600 font-bold text-xs font-mono mb-2">
                            Exception: <%= exception != null ? exception.getClass().getName() : "Unknown Error" %>
                        </p>
                        <p class="text-gray-600 text-xs font-mono whitespace-pre-wrap">
                            Message: <%= exception != null ? exception.getMessage() : "No message available" %>
                        </p>
                    </div>
                </div>
            </details>
        </div>

    </div>
</div>

</body>
</html>