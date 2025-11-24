import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "../styles/Login.css";

function Login() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });

  const onChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    navigate("/");
  };

  return (
    <div className="login-page">
      <div className="login-container">
        <div className="login-card">
          <div className="login-header">
            <Link to="/" className="login-name">
              <span>OtoBul</span>
            </Link>
            <p className="login-title">Hesabınıza giriş yapın</p>
          </div>

          <form className="login-form" onSubmit={handleSubmit}>
            <div className="form-container">
              <label htmlFor="email" className="form-label">
                Email Adresi
              </label>
              <input
                type="email"
                id="email"
                name="email"
                value={formData.email}
                onChange={onChange}
                className="form-input"
                placeholder="ttavlan@gmail.com"
              />
            </div>

            <div className="form-container">
              <label htmlFor="password" className="form-label">
                Şifre
              </label>
              <input
                type="password"
                id="password"
                name="password"
                value={formData.password}
                onChange={onChange}
                className="form-input"
                placeholder="****"
              />
            </div>

            <button type="submit" className="submit-btn">
              Giriş Yap
            </button>
          </form>

          <div className="login-footer">
            <p>
              Hesabınız yok mu?{" "}
              <Link to="/register" className="register-link">
                Kayıt Ol
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Login;
