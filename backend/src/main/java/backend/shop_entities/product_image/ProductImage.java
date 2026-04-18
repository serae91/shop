package backend.shop_entities.product_image;

import backend.shop_entities.product.Product;
import io.quarkus.runtime.annotations.RegisterForReflection;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "product_images")
@RegisterForReflection
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductImage {
    @Id
    @GeneratedValue(generator = "product_images_sequence", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "product_images_sequence", sequenceName = "product_images_sequence", allocationSize = 1)
    @Column(nullable = false)
    private Long id;

    @OneToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "product_id", unique = true)
    private Product product;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String url;
}
