import { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import "../styles/Register.css";

function Register() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    firstName: "",
    lastName: "",
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
    <div className="register-page">
      <div className="register-container">
        <div className="register-card">
          <div className="register-header">
            <Link to="/" className="register-name">
              <span>OtoBul</span>
            </Link>
            <p className="register-title">Hesap Oluştur</p>
          </div>

          <form className="register-form" onSubmit={handleSubmit}>
            <div className="form-container">
              <label htmlFor="firstName" className="form-label">
                Ad
              </label>
              <input
                type="text"
                id="firstName"
                name="firstName"
                value={formData.firstName}
                onChange={onChange}
                className="form-input"
                placeholder="Adınız"
              />
            </div>

            <div className="form-container">
              <label htmlFor="lastName" className="form-label">
                Soyad
              </label>
              <input
                type="text"
                id="lastName"
                name="lastName"
                value={formData.lastName}
                onChange={onChange}
                className="form-input"
                placeholder="Soyadınız"
              />
            </div>

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
                placeholder="En az 6 karakter"
              />
            </div>

            <button type="submit" className="submit-btn">
              Kayıt Ol
            </button>
          </form>

          <div className="register-footer">
            <p>
              Zaten hesabınız var mı?{" "}
              <Link to="/login" className="login-link">
                Giriş Yap
              </Link>
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Register;
