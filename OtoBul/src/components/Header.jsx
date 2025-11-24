import { Link, useNavigate } from "react-router-dom";
import "../styles/Header.css";

function Header() {
  const navigate = useNavigate();

  return (
    <header className="header">
      <div className="header-container">
        <Link to="/">
          <span className="name">OtoBul</span>
        </Link>
        <div className="header-buttons">
          <button className="btn btn-login" onClick={() => navigate("/login")}>
            Giriş Yap
          </button>
          <button
            className="btn btn-login"
            onClick={() => navigate("/register")}
          >
            Kayıt Ol
          </button>
          <button className="btn btn-advertise">İlan Ver</button>
        </div>
      </div>
    </header>
  );
}

export default Header;
