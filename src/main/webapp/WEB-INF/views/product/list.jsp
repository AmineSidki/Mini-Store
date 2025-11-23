<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<%@ page import="java.util.List" %>
<%@ page import="org.aminesidki.ministore.model.Product" %>

<html>
<head>
    <title>Product Management</title>

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
<body class="min-h-screen bg-gradient-to-r from-blue-100 via-purple-100 to-pink-100
             bg-[length:400%_400%] animate-gradient-pan p-8 relative">

<a href="logout" class="absolute top-6 left-6 flex items-center gap-2 text-gray-500 hover:text-red-500 font-bold py-2 px-4 bg-white/50 hover:bg-white rounded-full shadow-sm hover:shadow-md transition-all duration-300 z-10 backdrop-blur-sm">
    <svg class="w-5 h-5 transform rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path></svg>
    <span class="hidden md:inline">Log Out</span>
</a>

<div class="text-center mb-12 animate-fade-in-up max-w-7xl mx-auto pt-4">
    <div class="font-momo text-6xl bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent">
        Mini-Store
    </div>
    <div class="font-mono text-xl text-gray-500 mt-1">
        Inventory Dashboard
    </div>
</div>

<div class="container mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8 max-w-7xl pb-20">

    <a href= <%=request.getContextPath() + "/products/new"%>
       class="group flex flex-col items-center justify-center min-h-[350px] h-full bg-white/40 border-4 border-dashed border-gray-300 rounded-2xl hover:border-blue-400 hover:bg-blue-50/80 hover:scale-[1.02] transition-all duration-300 animate-fade-in-up cursor-pointer backdrop-blur-sm">

        <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center shadow-sm group-hover:shadow-md group-hover:scale-110 transition-all duration-300 mb-4">
            <svg class="w-8 h-8 text-gray-400 group-hover:text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
        </div>
        <span class="font-sans text-xl font-bold text-gray-500 group-hover:text-blue-600">Add New Item</span>
    </a>

    <%
        List<Product> productList = (List<Product>) request.getAttribute("products");

        if (productList != null && !productList.isEmpty()) {
            for (Product p : productList) {
    %>
    <div class="bg-white rounded-2xl shadow-xl overflow-hidden hover:shadow-2xl transition-all duration-300 animate-fade-in-up flex flex-col h-full border border-white/50 group">

        <div class="p-6 flex-grow">
            <div class="flex justify-between items-start mb-4">
                        <span class="bg-gray-100 text-gray-500 text-xs font-mono font-bold px-2 py-1 rounded-md uppercase tracking-wide">
                            #<%= p.getId() %>
                        </span>
                <span class="text-2xl font-bold text-gray-800">
                            $<%= String.format("%.2f", p.getPrice()) %>
                        </span>
            </div>

            <h3 class="font-sans text-2xl font-bold text-gray-800 mb-2 truncate group-hover:text-blue-600 transition-colors">
                <%= p.getName() %>
            </h3>

            <p class="font-sans text-gray-500 text-sm leading-relaxed mb-4 line-clamp-3">
                <%= p.getDescription() %>
            </p>

            <div class="text-xs text-gray-300 font-mono mt-2">
                Added: <%= p.getCreatedAt().toString().substring(0, 10) %>
            </div>
        </div>

        <div class="bg-gray-50 px-6 py-4 border-t border-gray-100 grid grid-cols-2 gap-3">

            <a href="<%=request.getContextPath()%>/products/edit?id=<%= p.getId() %>"
               class="flex items-center justify-center w-full bg-blue-100 hover:bg-blue-200 text-blue-700 text-sm font-bold py-2.5 rounded-xl transition-colors duration-200 gap-2">
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
                Edit
            </a>

            <form action="<%=request.getContextPath()%>/products/delete" method="post" class="w-full m-0 p-0"
                  onsubmit="return confirm('Are you sure you want to delete <%= p.getName() %>?');">

                <input type="hidden" name="id" value="<%= p.getId() %>">

                <button type="submit"
                        class="flex items-center justify-center w-full bg-red-100 hover:bg-red-200 text-red-700 text-sm font-bold py-2.5 rounded-xl transition-colors duration-200 gap-2">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
                    Delete
                </button>
            </form>

        </div>
    </div>
    <%
            }
        }
    %>

</div>

</body>
</html>