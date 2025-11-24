import { Link } from "react-router-dom";
import "../styles/ListingCard.css";

function ListingCard({ listing }) {
  return (
    <Link to={"/"} className="listing-card">
      <div className="listing-image"></div>

      <div className="listing-content">
        <div className="listing-info">
          <span>{listing.city}</span>
          <span>{listing.year}</span>
        </div>

        <p className="listing-title">{listing.title}</p>

        <div className="listing-price">{listing.price}</div>
      </div>
    </Link>
  );
}

export default ListingCard;
