package backend.shop_entities.product;

import backend.shop_entities.category.Category;
import backend.shop_entities.product_image.ProductImage;
import io.quarkus.runtime.annotations.RegisterForReflection;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.Instant;

@Entity
@Table(name = "products")
@RegisterForReflection
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {
    @Id
    @GeneratedValue(generator = "products_sequence", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "products_sequence", sequenceName = "products_sequence", allocationSize = 1)
    @Column(nullable = false)
    private Long id;

    @Column(length = 150, nullable = false)
    private String name;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal price;

    @Column(nullable = false)
    private Integer stock;

    @ManyToOne(optional = false)
    @JoinColumn(name = "category_id")
    private Category category;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @OneToOne(mappedBy = "product", cascade = CascadeType.ALL, optional = false)
    private ProductImage productImage;
}
