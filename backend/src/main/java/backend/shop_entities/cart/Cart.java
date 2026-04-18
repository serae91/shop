package backend.shop_entities.cart;

import backend.shop_entities.user.User;
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

import java.time.Instant;

@Entity
@Table(name = "carts")
@RegisterForReflection
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Cart {
    @Id
    @GeneratedValue(generator = "cart_items_sequence", strategy = GenerationType.SEQUENCE)
    @SequenceGenerator(name = "cart_items_sequence", sequenceName = "cart_items_sequence", allocationSize = 1)
    @Column(nullable = false)
    private Long id;

    @OneToOne(cascade = CascadeType.ALL, optional = false)
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    @Column(name = "created_at", nullable = false)
    private Instant createdAt;
}
