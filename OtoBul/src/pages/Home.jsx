import { useState } from "react";
import Header from "../components/Header";
import Footer from "../components/Footer";
import ListingCard from "../components/ListingCard";
import CategoryItem from "../components/CategoryItem";
import { categories, listings } from "../utils/Data";
import "../styles/Home.css";

function Home() {
  const [selectedCategory, setSelectedCategory] = useState("hepsi");

  return (
    <div className="home-page">
      <Header />
      <main className="home-content">
        <div className="content-container">
          <aside className="category">
            <h1 className="category-title">Kategoriler</h1>
            <ul className="category-list">
              {categories.map((category) => (
                <CategoryItem
                  key={category.id}
                  category={category}
                  selectedCategory={selectedCategory}
                  setSelectedCategory={setSelectedCategory}
                />
              ))}
            </ul>
          </aside>

          <section>
            <div className="listings-grid">
              {listings.map((listing) => (
                <ListingCard key={listing.id} listing={listing} />
              ))}
            </div>
          </section>
        </div>
      </main>

      <Footer />
    </div>
  );
}

export default Home;
