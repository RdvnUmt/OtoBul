import { Link } from "react-router-dom";
import "../styles/Footer.css";

function Footer() {
  return (
    <footer className="footer">
      <div className="footer-container">
        <div className="container">
          <p className="footer-heading">Kurumsal</p>
          <ul className="footer-list">
            <li>
              <Link to="/">Hakkımızda</Link>
            </li>
            <li>
              <Link to="/">İletişim</Link>
            </li>
          </ul>
        </div>

        <div className="container">
          <p className="footer-heading">Destek</p>
          <ul className="footer-list">
            <li>
              <Link to="/">Yardım Merkezi</Link>
            </li>
            <li>
              <Link to="/">SSS</Link>
            </li>
          </ul>
        </div>

        <div className="container">
          <p className="footer-heading">İletişim</p>
          <ul className="footer-list">
            <li>info@otobul.com</li>
            <li>+90 555 555 55 55</li>
          </ul>
        </div>
      </div>

      <div className="footer-bottom">
        <p>&copy; 2025 OtoBul. Tüm hakları saklıdır.</p>
      </div>
    </footer>
  );
}

export default Footer;
