<%@ page contentType="text/html;charset=UTF-8" language="java" session="false"%>
<%@ page import="org.aminesidki.ministore.model.Product" %>
<%
    // Retrieve the product object (will be null if it's a fresh 'new' form)
    Product product = (Product) request.getAttribute("product");

    // UPDATED: Logic based on the "isNew" boolean attribute
    Boolean isNewAttr = (Boolean) request.getAttribute("isNew");

    // Safety check: if the attribute is missing, default to true (New Mode)
    boolean isNew = (isNewAttr == null || isNewAttr);

    // Set the form variables based on mode
    String formAction = isNew ? "/products" : "/products/update";
    String title = isNew ? "New Product" : "Edit Product";
    String btnText = isNew ? "Create Product" : "Save Changes";
%>

<html>
<head>
    <title><%= title %></title>

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

<div class="w-full max-w-lg">

    <div class="bg-white p-8 shadow-2xl rounded-2xl animate-fade-in-up border border-white/50 relative">

        <a href="${pageContext.request.contextPath}/products" class="absolute top-6 right-6 text-gray-400 hover:text-gray-600 transition-colors">
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
        </a>

        <div class="text-center mb-8">
            <div class="font-momo text-5xl bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent">
                Mini-Store
            </div>
            <div class="font-mono text-xl text-gray-500 mt-2">
                <%= title %>
            </div>
        </div>

        <form action="<%=request.getContextPath()+formAction %>" method="post" class="space-y-5">

            <% if(!isNew && product != null) { %>
            <input type="hidden" name="id" value="<%= product.getId() %>">
            <% } %>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-1 ml-4">Product Name</label>
                <input
                        required
                        name="name"
                        type="text"
                        placeholder="e.g. Vintage Camera"
                        value="<%= (!isNew && product != null) ? product.getName() : "" %>"
                        class="font-sans text-xl w-full bg-gray-50 border border-gray-200 rounded-2xl px-5 py-3 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all duration-300"
                >
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-1 ml-4">Price ($)</label>
                <input
                        required
                        name="price"
                        type="number"
                        step="0.01"
                        placeholder="0.00"
                        value="<%= (!isNew && product != null) ? product.getPrice() : "" %>"
                        class="font-sans text-xl w-full bg-gray-50 border border-gray-200 rounded-2xl px-5 py-3 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all duration-300"
                >
            </div>

            <div>
                <label class="block text-sm font-bold text-gray-700 mb-1 ml-4">Description</label>
                <textarea
                        required
                        name="description"
                        rows="4"
                        placeholder="Describe the item details..."
                        class="font-sans text-lg w-full bg-gray-50 border border-gray-200 rounded-2xl px-5 py-3 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:bg-white transition-all duration-300 resize-none"
                ><%= (!isNew && product != null) ? product.getDescription() : "" %></textarea>
            </div>

            <button
                    type="submit"
                    class="font-sans text-xl w-full rounded-full px-5 py-3 !mt-8 bg-gradient-to-r from-blue-600 to-blue-500 text-white font-bold shadow-lg hover:shadow-xl hover:scale-[1.02] active:scale-95 transition-all duration-300 ease-in-out flex items-center justify-center gap-2"
            >
                <% if(!isNew) { %>
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"></path></svg>
                <% } else { %>
                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path></svg>
                <% } %>
                <%= btnText %>
            </button>

            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/products" class="text-gray-400 hover:text-gray-600 font-medium transition-colors">
                    Cancel
                </a>
            </div>

        </form>
    </div>
</div>

</body>
</html>