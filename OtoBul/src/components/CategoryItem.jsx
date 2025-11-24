import "../styles/CategoryItem.css";


function CategoryItem({ category, selectedCategory, setSelectedCategory }) {
    
  return (
    <li
      key={category.id}
      className={`category-item ${
        selectedCategory === category.id ? "active" : ""
      }`}
      onClick={() => setSelectedCategory(category.id)}
    >
      <span className="category-name">{category.name}</span>
      <span className="category-count">
        {category.listingCount.toLocaleString("tr-TR")}
      </span>
    </li>
  );
}

export default CategoryItem;
