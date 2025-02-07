<% 
String message =(String) session.getAttribute("successMessage");
if(message !=null)
{
	

%>

 <div class="alert alert-success alert-dismissible fade show custom-alert text-center" role="alert">
            <i class="bi bi-check-circle-fill"></i>  <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>


<%  

session.removeAttribute("message");
}
%>
<!-- Optional styling for custom alert -->
<style>
    .custom-alert {
        font-size: 16px;
        font-weight: 500;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    
    .bi {
        font-size: 20px;
        margin-right: 8px;
    }
    
    .alert {
        opacity: 1;
        transition: opacity 0.5s ease-out;
    }
</style>

<!-- Bootstrap Icons for better visuals -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

<script>
    // Automatically hide the message after 5 seconds
    setTimeout(() => {
        let alertBox = document.querySelector(".custom-alert");
        if (alertBox) {
            alertBox.classList.add("fade");
            setTimeout(() => alertBox.style.display = "none", 500);
        }
    }, 5000);
</script>

